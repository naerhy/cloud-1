SHELL := /bin/bash
python := python3
SRC_DIR := .
VENV_DIR := cloud_venv
DEP_FILE := requirements.txt

# The URL to the dataset
DATA_DIR := data

define venvWrapper
	{\
	. $(VENV_DIR)/bin/activate; \
	$1; \
	}
endef

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  install:    Install the project"
	@echo "  freeze:     Freeze the dependencies"
	@echo "  fclean:     Remove the virtual environment and the datasets"
	@echo "  clean:      Remove the cache files"
	@echo "  re:         Reinstall the project"
	@echo "  phony:      Run the phony targets"

start:
	@{ \
		echo "Starting the application..."; \
		if [ ! -d ${VENV_DIR} ]; then echo "Virtual environment not found. Please run 'make install' first."; exit 1; fi; \
		$(call venvWrapper, ansible-playbook -i ./setup/hosts ./setup/deploy.yml); \
	}

install:
		@{ \
		echo "Setting up..."; \
		if [ -z ${ASSET_URL} ] || [ -d ${DATA_DIR} ]; then echo "nothing to download"; else \
			filename=$(notdir ${ASSET_URL}); \
			wget --no-check-certificate -O $${filename} ${ASSET_URL}; \
			mkdir -p ${DATA_DIR}/; \
			if [[ $${filename} == *.zip ]]; then \
				echo "Unzipping..."; \
				unzip -o $${filename} -d ${DATA_DIR}/; \
			elif [[ $${filename} == *.tar || $${filename} == *.tar.gz || $${filename} == *.tgz ]]; then \
				echo "Untarring..."; \
				tar -xvf $${filename} -C ${DATA_DIR}/; \
			rm -rf $${filename}; \
			fi; \
		fi; \
		python3 -m venv ${VENV_DIR}; \
		. ${VENV_DIR}/bin/activate; \
		if [ -f ${DEP_FILE}  ]; then \
			pip install -r ${DEP_FILE}; \
			echo "Installing dependencies...DONE"; \
		fi; \
		}

freeze:
	$(call venvWrapper, pip freeze > ${DEP_FILE})

fclean: clean
	rm -rf bin/ include/ lib/ lib64 pyvenv.cfg share/ etc/ $(VENV_DIR)

clean:
	rm -rf ${SRC_DIR}/__pycache__ */**/**/__pycache__ */**/__pycache__ */__pycache__

re: fclean install

phony: install freeze fclean clean re help
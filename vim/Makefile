REPO_PREFIX_PATTERN = %/
PLUGIN_DIR = .vim/pack/plugins

START_DIR  :=  $(PLUGIN_DIR)/start
OPT_DIR    :=  $(PLUGIN_DIR)/opt

# Plugins to be installed to the start directory
# If the repository is in github, just the repository name is enough.
START_EDIT_PLUGINS = \
										 tpope/vim-surround    \
										 tpope/vim-unimpaired  \
										 tpope/vim-repeat      \
										 tpope/vim-commentary  \
										 SirVer/ultisnips      \
										 honza/vim-snippets    \
										 udalov/kotlin-vim    \

START_USABILITY_PLUGINS = \
													romainl/vim-cool                \
													machakann/vim-highlightedyank   \
													junegunn/fzf.vim                \

START_GIT_PLUGINS    =  tpope/vim-fugitive
START_COLOR_SCHEMES  =  ayu-theme/ayu-vim lifepillar/vim-colortemplate

# When column -t is not enough
OPT_PLUGINS = junegunn/vim-easy-align

START_PLUGINS := $(START_EDIT_PLUGINS) $(START_USABILITY_PLUGINS) $(START_GIT_PLUGINS) $(START_COLOR_SCHEMES) 

# Default target, install all the start and opt plugins
all: $(START_PLUGINS) $(OPT_PLUGINS)

$(START_PLUGINS): create_start_dir
	@if [ "$(wildcard $(START_DIR)/$(lastword $(subst /, ,$@))/.)" = "" ]; then \
		echo "--Installing plugin "$@; \
		git clone https://github.com/$@ $(START_DIR)/$(lastword $(subst /, ,$@)); \
	else \
		echo "--Plugin "$@" already installed. skipping"; \
	fi

$(OPT_PLUGINS): create_start_dir
	@if [ "$(wildcard $(OPT_DIR)/$(lastword $(subst /, ,$@))/.)" = "" ]; then \
		echo "--Installing plugin "$@; \
		git clone https://github.com/$@ $(OPT_DIR)/$(lastword $(subst /, ,$@)); \
	else \
		echo "--Plugin "$@" already installed. skipping"; \
	fi

create_start_dir:
	@mkdir -p  $(START_DIR)

create_opt_dir:
		@mkdir -p  $(OPT_DIR)

update:
	@for plugin in $(START_PLUGINS) ; do \
		echo '--Updating '$$plugin'...'; \
		git --git-dir=$(START_DIR)'/'$${plugin##*/}/.git pull; \
	done

.PHONY: clean
clean:
	@echo '--Removing the plugin directories...'
	@rm -rf $(START_DIR) 2>/dev/null || true
	@rm -rf $(OPT_DIR) 2>/dev/null || true
	@echo '--Done!'

.ONESHELL:

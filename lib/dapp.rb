require 'pathname'
require 'fileutils'
require 'tmpdir'
require 'digest'
require 'timeout'
require 'base64'
require 'mixlib/cli'
require 'mixlib/shellout'
require 'securerandom'
require 'excon'
require 'json'
require 'ostruct'
require 'time'
require 'i18n'
require 'paint'

require 'net_status'

require 'dapp/version'
require 'dapp/core_ext/hash'
require 'dapp/helper/cli'
require 'dapp/helper/trivia'
require 'dapp/helper/sha256'
require 'dapp/helper/net_status'
require 'dapp/prctl'
require 'dapp/error/base'
require 'dapp/error/application'
require 'dapp/error/dappfile'
require 'dapp/error/build'
require 'dapp/error/config'
require 'dapp/error/project'
require 'dapp/error/shellout'
require 'dapp/error/registry'
require 'dapp/exception/base'
require 'dapp/exception/introspect_image'
require 'dapp/exception/registry'
require 'dapp/lock/error'
require 'dapp/lock/base'
require 'dapp/lock/file'
require 'dapp/cli'
require 'dapp/cli/base'
require 'dapp/cli/build'
require 'dapp/cli/push'
require 'dapp/cli/spush'
require 'dapp/cli/list'
require 'dapp/cli/stages'
require 'dapp/cli/stages/flush_local'
require 'dapp/cli/stages/flush_repo'
require 'dapp/cli/stages/cleanup_local'
require 'dapp/cli/stages/cleanup_repo'
require 'dapp/cli/stages/push'
require 'dapp/cli/stages/pull'
require 'dapp/cli/run'
require 'dapp/cli/cleanup'
require 'dapp/cli/bp'
require 'dapp/cli/mrproper'
require 'dapp/cli/stage_image'
require 'dapp/filelock'
require 'dapp/config/base'
require 'dapp/config/dimg'
require 'dapp/config/dimg_group_base'
require 'dapp/config/dimg_group_main'
require 'dapp/config/dimg_group'
require 'dapp/config/artifact_group'
require 'dapp/config/directive/base'
require 'dapp/config/directive/git_artifact_local'
require 'dapp/config/directive/git_artifact_remote'
require 'dapp/config/directive/artifact'
require 'dapp/config/directive/chef'
require 'dapp/config/directive/shell/dimg'
require 'dapp/config/directive/shell/artifact'
require 'dapp/config/directive/docker/base'
require 'dapp/config/directive/docker/dimg'
require 'dapp/config/directive/docker/artifact'
require 'dapp/config/directive/mount'
require 'dapp/builder/base'
require 'dapp/builder/chef'
require 'dapp/builder/chef/error'
require 'dapp/builder/chef/cookbook_metadata'
require 'dapp/builder/chef/berksfile'
require 'dapp/builder/shell'
require 'dapp/build/stage/mod/logging'
require 'dapp/build/stage/mod/group'
require 'dapp/build/stage/base'
require 'dapp/build/stage/ga_base'
require 'dapp/build/stage/ga_dependencies_base'
require 'dapp/build/stage/artifact_base'
require 'dapp/build/stage/artifact_default'
require 'dapp/build/stage/from'
require 'dapp/build/stage/import_artifact'
require 'dapp/build/stage/before_install'
require 'dapp/build/stage/before_install_artifact'
require 'dapp/build/stage/ga_archive_dependencies'
require 'dapp/build/stage/ga_archive'
require 'dapp/build/stage/install/ga_pre_install_patch_dependencies'
require 'dapp/build/stage/install/ga_pre_install_patch'
require 'dapp/build/stage/install/install'
require 'dapp/build/stage/install/ga_post_install_patch_dependencies'
require 'dapp/build/stage/install/ga_post_install_patch'
require 'dapp/build/stage/after_install_artifact'
require 'dapp/build/stage/before_setup'
require 'dapp/build/stage/before_setup_artifact'
require 'dapp/build/stage/setup/ga_pre_setup_patch_dependencies'
require 'dapp/build/stage/setup/ga_pre_setup_patch'
require 'dapp/build/stage/setup/setup'
require 'dapp/build/stage/setup/chef_cookbooks'
require 'dapp/build/stage/setup/ga_post_setup_patch_dependencies'
require 'dapp/build/stage/setup/ga_post_setup_patch'
require 'dapp/build/stage/after_setup_artifact'
require 'dapp/build/stage/ga_latest_patch'
require 'dapp/build/stage/docker_instructions'
require 'dapp/build/stage/ga_artifact_patch'
require 'dapp/build/stage/build_artifact'
require 'dapp/project/lock'
require 'dapp/project/ssh_agent'
require 'dapp/project/dappfile'
require 'dapp/project/command/common'
require 'dapp/project/command/build'
require 'dapp/project/command/bp'
require 'dapp/project/command/cleanup'
require 'dapp/project/command/mrproper'
require 'dapp/project/command/stage_image'
require 'dapp/project/command/list'
require 'dapp/project/command/push'
require 'dapp/project/command/run'
require 'dapp/project/command/spush'
require 'dapp/project/command/stages/common'
require 'dapp/project/command/stages/cleanup_local'
require 'dapp/project/command/stages/cleanup_repo'
require 'dapp/project/command/stages/flush_local'
require 'dapp/project/command/stages/flush_repo'
require 'dapp/project/command/stages/push'
require 'dapp/project/command/stages/pull'
require 'dapp/project/logging/base'
require 'dapp/project/logging/process'
require 'dapp/project/logging/paint'
require 'dapp/project/logging/i18n'
require 'dapp/project/deps/base'
require 'dapp/project/deps/gitartifact'
require 'dapp/project/shellout/streaming'
require 'dapp/project/shellout/base'
require 'dapp/project/shellout/system'
require 'dapp/project'
require 'dapp/docker_registry'
require 'dapp/docker_registry/mod/request'
require 'dapp/docker_registry/mod/authorization'
require 'dapp/docker_registry/base'
require 'dapp/docker_registry/default'
require 'dapp/application/git_artifact'
require 'dapp/application/path'
require 'dapp/application/tags'
require 'dapp/application/stages'
require 'dapp/application'
require 'dapp/artifact'
require 'dapp/image/argument'
require 'dapp/image/docker'
require 'dapp/image/stage'
require 'dapp/image/scratch'
require 'dapp/git_repo/base'
require 'dapp/git_repo/own'
require 'dapp/git_repo/remote'
require 'dapp/git_artifact'

# Dapp
module Dapp
  def self.root
    File.expand_path('../..', __FILE__)
  end
end

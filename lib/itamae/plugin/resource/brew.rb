require 'itamae'

module Itamae
  module Plugin
    module Resource
      class Brew < Itamae::Resource::Base
        define_attribute :action, default: :install
        define_attribute :name, type: String, default_name: true
        define_attribute :options, type: String
        define_attribute :user, type: String

        def pre_action
          case @current_action
          when :install
            attributes.installed = true
          when :uninstall
            attributes.installed = false
          end
        end

        def set_current_attributes
          if node[:linuxbrew] && node[:linuxbrew][:user]
            attributes.user ||= node[:linuxbrew][:user]
          elsif node[:linuxbrew] && node[:linuxbrew][:users]
            attributes.user ||= node[:linuxbrew][:users].first
          end

          ensure_brew_availability

          installed = installed_packages.find { |package_name| package_name == attributes.name }
          current.installed = !!installed
        end

        def action_install(options)
          unless current.installed
            install!
            updated!
          end
        end

        def action_uninstall(action_options)
          if current.installed
            uninstall!
            updated!
          end
        end

        def installed_packages
          run_command(wrap_bin_bash('brew list')).stdout.lines.map do |line|
            line.strip.split(/\s+/)
          end.flatten
        rescue Backend::CommandExecutionError
          []
        end

        def install!
          cmd = ['brew', 'install', *Array(attributes.options)]
          cmd << attributes.name
          run_command(wrap_bin_bash(cmd))
        end

        def uninstall!
          cmd = ['brew', 'uninstall', *Array(attributes.options)]
          cmd << attributes.name
          run_command(wrap_bin_bash(cmd))
        end

        private

        def ensure_brew_availability
          if run_command(wrap_bin_bash('which brew'), error: false).exit_status != 0
            raise '`brew` command is not available. Please install brew.'
          end
        end

        def wrap_bin_bash(cmd)
          cmd = cmd.join(' ') if cmd.is_a? Array
          "/bin/bash -lc \"#{cmd}\""
        end
      end
    end
  end
end

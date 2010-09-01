gem 'buildr-bnd', :version => '0.0.5'
gem 'buildr-iidea', :version => '0.0.7'
gem 'buildr-ipojo', :version => '0.0.1'

require 'buildr_bnd'
require 'buildr_ipojo'
require 'buildr_iidea'

VERSION_NUMBER = "1.0.0"
GROUP = "osgiui"

# Specify Maven 2.0 remote repositories here, like this:
repositories.remote << "http://www.ibiblio.org/maven2/"

repositories.remote << Buildr::Bnd.remote_repository
repositories.remote << Buildr::Ipojo.remote_repository

OSGI_CORE = 'org.apache.felix:org.osgi.core:jar:1.4.0'
OSGI_COMPENDIUM = 'org.apache.felix:org.osgi.compendium:jar:1.4.0'
IPOJO_ANNOTATIONS = Buildr::Ipojo.annotation_artifact

class CentralLayout < Layout::Default
  def initialize(key, top_level, use_subdir)
    super()
    prefix = top_level ? '' : '../'
    subdir = use_subdir ? "/#{key}" : ''
    self[:target] = "#{prefix}target#{subdir}"
    self[:target, :main] = "#{prefix}target#{subdir}"
    self[:reports] = "#{prefix}reports#{subdir}"
  end
end

def define_with_central_layout(name, top_level = false, use_subdir = true, & block)
  define(name, :layout => CentralLayout.new(name, top_level, use_subdir), & block)
end

desc "The Osgi UI project"
define_with_central_layout( "osgiui", true, false) do

  project.version = VERSION_NUMBER
  project.group = GROUP
  compile.options.source = '1.6'
  compile.options.target = '1.6'
  compile.options.lint = 'all'

  desc "A bundle providing functionality for building the UI"
  define_with_central_layout "framework" do
    compile.with OSGI_CORE, IPOJO_ANNOTATIONS
    project.ipojoize!
    package(:bundle).tap do |bnd|
      bnd['Bundle-Activator'] = "osgiui.framework.Launcher"
      bnd['Export-Package'] = "osgiui.*;version=#{version}"
    end
  end
end

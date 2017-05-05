require 'pathname'
require 'shell'

# Submodules to keep synchronized
$submodule_base_dirs = %w(
  ./oh-my-zsh
  ./rbenv
)

# Symlinks to link into the home directory
$symlinks = {
  # Keys: dotfile under ~
  # Values: path relative to this repo
  '.oh-my-zsh'           => 'oh-my-zsh',
  '.vimrc'               => 'vim/vimrc',
  '.vim'                 => 'vim',
  '.zshrc'               => 'zshrc',
  '.inputrc'             => 'inputrc',
  '.bash_profile'        => 'bash_profile',
  '.irbrc'               => 'irbrc',
  '.gitconfig'           => 'gitconfig',
  '.gitignore'           => 'gitignore',
  '.rbenv'               => 'rbenv',
  '.git-completion.bash' => 'git-completion.bash',
  '.git-prompt.sh'       => 'git-prompt.sh',
  '.kcfg.zsh'            => 'kcfg.zsh',
  '.config/nvim'         => 'vim',
}

$submodules = $submodule_base_dirs.map{|f| "#{f}/.git"}

def git_submodule(*args, &block)
  desc "Git submodule for path #{args.first}"
  file("#{args.first}/.git") do
    sh "git submodule update --init --recursive #{args.first}"
  end
end

$submodule_base_dirs.each do |path|
  git_submodule path
end

desc "Add rbenv-gemset plugin to rbenv"
file './rbenv/plugins/rbenv-gemset' => ['./rbenv/.git'] do
  # We clone instead of use a submodule so it can be gitignored... adding a
  # submodule creates an issue where you have uncommitted changes in the rbenv
  # repo.
  sh "git clone git://github.com/jf/rbenv-gemset.git rbenv/plugins/rbenv-gemset"
end

desc "Add ruby-build plugin to rbenv"
file './rbenv/plugins/ruby-build' => ['./rbenv/.git'] do
  sh "git clone git://github.com/sstephenson/ruby-build.git rbenv/plugins/ruby-build"
end

task :update do
  sh 'git submodule foreach git checkout master'
  sh 'git submodule foreach git pull --rebase'
end

desc "Create symlinks from this directory to the appropriate dotfiles in the home directory (currently: #{ENV['HOME']}"
task :symlink => $submodules do
  this_directory   = File.expand_path('..', File.realdirpath(__FILE__))
  homedir_pathname = Pathname.new(ENV['HOME'])

  $symlinks.each do |dotfile, path|
    dotfile_pathname = Pathname.new(File.join(ENV['HOME'], dotfile))
    path_pathname    = Pathname.new(File.join(this_directory, path))
    sh "mkdir -p #{File.dirname(dotfile_pathname.to_s)}"
    sh "ln -sfn #{path_pathname.relative_path_from(dotfile_pathname.parent)} #{dotfile_pathname.to_s}"
  end
end

task :default => $submodules + [ './rbenv/plugins/ruby-build', './rbenv/plugins/rbenv-gemset' ]

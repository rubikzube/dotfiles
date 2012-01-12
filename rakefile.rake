require 'rake'

def check_directory(directory)
  if not File.directory?(directory) 
		Dir::mkdir(directory)
	end
end

desc "Hook our dotfiles into system-standard positions."
task :install do
	
	home = ENV["HOME"]
	
	### Install Pathogen ###
	puts "Install Pathogen (y)?"
	if STDIN.gets.chomp.downcase == 'y'
		autoload_dir = "#{home}/.vim/autoload"
		bundle_dir = "#{home}/.vim/bundle"
		pathogen_url = 'https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim'
		check_directory autoload_dir
		check_directory bundle_dir
		`curl -so #{autoload_dir}/pathogen.vim #{pathogen_url}`
	end
	
	### Sym link in all configuration files, which have the symlink sufflix ### 
	
	linkables = Dir.glob('*/**{.symlink}')
	skip_all = false
	overwrite_all = false
	backup_all = false
	
	linkables.each do |linkable|
		overwrite = false
		backup = false
		
		file = linkable.split('/').last.split('.symlink').last
		target = "#{home}/.#{file}"
	
		if File.exists?(target) || File.symlink?(target)
			unless skip_all || overwrite_all || backup_all
			puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
			case STDIN.gets.chomp
				when 'o' then overwrite = true
				when 'b' then backup = true
				when 'O' then overwrite_all = true
				when 'B' then backup_all = true
				when 'S' then skip_all = true
				end
			end
			FileUtils.rm_rf(target) if overwrite || overwrite_all
			`mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
		end
		`ln -s "$PWD/#{linkable}" "#{target}"`
	end
	
	### Install VIM themes ### 
	puts "Install VIM themes (y)?"
	if STDIN.gets.chomp.downcase == 'y'
		color_dir = "#{home}/.vim/colors"
		check_directory color_dir
		`curl -so #{color_dir}/solarized.vim https://github.com/altercation/vim-colors-solarized/tree/master/colors/solarized.vim`
		`curl -so #{color_dir}/molokai.vim https://bitbucket.org/sjl/dotfiles/raw/2f979e8ca55a/vim/colors/molokai.vim`
	end
	
end
task :default => 'install'
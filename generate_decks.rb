#!/usr/bin/env ruby

require 'pp'
require 'optparse'

options = {
    'masterminds' => 1,
    'schemes' => 1,
}

optparse = OptionParser.new do|opts|
    opts.banner = "Usage: generate_decks.rb --villains <num> --henchmen <num> --heroes <num>"

    options['villains'] = 1
       opts.on( '', '--villains <num>', 'Number of villains to generate' ) do|num|
       options['villains'] = num
    end

    options['henchmen'] = 1
       opts.on( '', '--henchmen <num>', 'Number of henchmen to generate' ) do|num|
       options['henchmen'] = num
    end

    options['heroes'] = 1
       opts.on( '', '--heroes <num>', 'Number of heroes to generate' ) do|num|
       options['heroes'] = num
    end

    opts.on( '-h', '--help', 'Display this screen' ) do
         puts opts
         exit
    end
end
optparse.parse!

#  pp options

decks = Hash.new
types = [ 'masterminds', 'schemes', 'villains', 'henchmen', 'heroes' ]
file = File.new("cards.dat", "r")
current_type = ''
while (line = file.gets)
    line = line.chomp
    if types.include?( line )
        current_type = line
        decks[ current_type ] = Array.new
    else
        decks[ current_type ].push( line )
    end
end
file.close

#  pp decks

types.each {
    |type|
    puts( '== ' + type + ' ==' )
    sample_size = options[ type ].to_i
    puts( "\t*" + decks[ type ].sample( sample_size ).join("\n\t*") )
}

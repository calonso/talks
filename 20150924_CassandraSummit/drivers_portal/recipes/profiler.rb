
results = RubyProf.profile do


end

printer = RubyProf::GraphPrinter.new results
printer.print(STDOUT, min_percent: 2)

require_relative 'optimusparser'
require_relative 'bumblebee'
require_relative 'bplc'
require_relative 'smc'


$smc = SMC.new
bplc = BPLC.new

rec_code="
module rmod
  func fact(x) {
    var ret = 1, y = 1

    if (x == 1) {
      ret := 1
    } else {
      y := x - 1;
      ret := x * fact(y)
    }

    return ret
  }

  proc printFact() {
    print(fact(5))
  }

  printFact()

end"

fact_code = "
module modtop
  func fact(x,y) {
    const w = 1
    while (x > 0) do {
      y := y * x;
      x := x - w
    }

    return y
  }
  fact(5,1)
end"

fact_test_code = "
module modtop
  proc fact(x) {
    var x = 5;
    var y = 1;
    const w = 1122

    while (x > 0) do {
      y := y * x;
      x := top(x) - top(x)
    };

    print(y)
  }

  func top(x) {
    var x = 5

    if (x > 0) {
      print(x)
    }

    return 1
  }

  fact(2)
  top(1)
end"

test_code = "
module toptop
  proc test(x) {
    var y = 1

    if (y == 1) {
      var y = 2
    }
  }

  test(0)
end"

code = test_code

puts code
puts

$smc = SMC.new
bplc = BPLC.new
Bumblebee.new.apply(OptimusParser.new.rollOut(code))
bplc.vamosRodar()

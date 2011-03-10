# This doesn't take into account things like lambdas, procs, or objects that might be unordered, it's mostly
# just for some convenience so we can check two basic objects without needing to check individual
# primitives piecemeal

RSpec::Matchers.define :be_functionally_equivalent_to do |expected|
  match do |actual|
    return false unless (actual.class == expected.class)
    actual_values = actual.instance_variables.sort.map { |v| actual.instance_eval(v) }
    expected_values = expected.instance_variables.sort.map { |v| expected.instance_eval(v) }
    actual_values == expected_values
  end
end


require "spec"
require "../src/safe_ecr"
require "../src/safe_ecr/processor"

# unclear why this path fix is needed
module ECR
  macro embed(filename, io_name)
    \{{ run("../src/safe_ecr/process", {{filename}}, {{io_name.id.stringify}}) }}
  end
end

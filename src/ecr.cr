require "ecr"

module ECR
  macro embed(filename, io_name)
    \{{ run("safe_ecr/process", {{filename}}, {{io_name.id.stringify}}) }}
  end
end

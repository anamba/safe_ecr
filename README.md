# safe_ecr - Output safety for ECR

[![Version](https://img.shields.io/github/tag/anamba/safe_ecr.svg?maxAge=360)](https://github.com/anamba/safe_ecr/releases/latest)
[![Build Status](https://travis-ci.org/anamba/safe_ecr.svg?branch=master)](https://travis-ci.org/anamba/safe_ecr)
[![License](https://img.shields.io/github/license/anamba/safe_ecr.svg)](https://github.com/anamba/safe_ecr/blob/master/LICENSE)

Overrides default ECR module with one that does HTML escaping by default. Inspired by ActiveSupport's output safety.

HTML safe strings are wrapped by a new class, `SafeECR::HTMLSafeString`. When `String`s and `HTMLSafeString`s are combined via `+`, the result is an `HTMLSafeString` (with any HTML in the original `String` escaped).

Considering adding a `HTMLSafeString::Builder` to support `HTMLSafeString.build` (a la `String.build`).

## Installation

1. Add the dependency to your `shard.yml`:
```yaml
dependencies:
  safe_ecr:
    github: anamba/safe_ecr
```
2. Run `shards install`

## Usage

Require the module:

```crystal
require "safe_ecr"
```

Include the helpers (`h` and `raw`) where you need them:

```crystal
include SafeECR::Helpers
```

Then, in your ECR templates:

```erb
Hello, world!
<%= "Dangerous stuff like #{user.profile} gets escaped, since they could include <script>...</script>" %>
<%= "<em>You can manually mark strings as HTML-safe as needed...</em>".html_safe %>
<%= raw "<strong>Or use the raw helper, which does the same thing.</strong>" %>
```

## Contributing

1. Fork it (<https://github.com/anamba/safe_ecr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Aaron Namba](https://github.com/anamba) - creator and maintainer

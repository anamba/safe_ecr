# safe_ecr - Output safety for ECR

[![Version](https://img.shields.io/github/tag/anamba/safe_ecr.svg?maxAge=360)](https://github.com/anamba/safe_ecr/releases/latest)
[![Build Status](https://travis-ci.org/anamba/safe_ecr.svg?branch=master)](https://travis-ci.org/anamba/safe_ecr)
[![License](https://img.shields.io/github/license/anamba/safe_ecr.svg)](https://github.com/anamba/safe_ecr/blob/master/LICENSE)

Overrides default ECR module with one that does HTML escaping by default. Inspired by ActiveSupport's output safety.

A few brief examples:

```erb
<%= "Hello,<br> world!" %>                 # => Hello,&lt;br&gt; world!
<%=raw "Hello,<br> world!" %>              # => Hello,<br> world!
<%= "Hello,<br> world!".html_safe %>       # => Hello,<br> world!
<%= "Hello," + "<br> world!".html_safe %>  # => Hello,<br> world!
<%= "Hello,<br>" + " world!".html_safe %>  # => Hello,&lt;br&gt; world!
```

ECR will only output HTML safe strings, represented by a new class, `SafeECR::HTMLSafeString`. `HTMLSafeString`s can be created implicitly (the first and last lines of the example above) or explicitly (the second, third and fourth lines, plus the "` world!`" part of the last line).

Note that as shown in the last line, when `String`s and `HTMLSafeString`s are combined via `+`, the result is an `HTMLSafeString` (with any HTML in the original `String` escaped). If you *don't* want this behavior, just call `#to_s` on the `HTMLSafeString` first to convert it to a regular string before combining.

## Versioning

SafeECR is closely tied to ECR, so starting with 0.28.0, the SafeECR version will indicate the version of Crystal it works with.

For Crystal 0.27.0, use v0.2.0.

## Limitations

Crystal's `String` class cannot be inherited from, nor can it have additional properties added to it, which is why `HTMLSafeString` is an entirely unrelated class. As a result, using this shard will likely require a *lot* of code changes in existing HTML helper methods. (A companion shard to patch JasperHelpers for use with this shard is coming soon.)

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

## Amber-specific changes

In your layout, add the `raw` helper:

```erb
<%= raw content %>
```

Likewise, anytime you call `render` directly in a template file, it should now be `raw render`. (I considered overriding `render` to return an `HTMLSafeString`, but decided against it for now.)

## Contributing

1. Fork it (<https://github.com/anamba/safe_ecr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Aaron Namba](https://github.com/anamba) - creator and maintainer

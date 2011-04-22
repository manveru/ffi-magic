# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ffi-magic}
  s.version = "2011.04"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael 'manveru' Fellinger"]
  s.date = %q{2011-04-22}
  s.email = %q{m.fellinger@gmail.com}
  s.files = ["LICENSE", "MANIFEST", "README.md", "Rakefile", "doc/AUTHORS", "doc/CHANGELOG", "ffi-magic.gemspec", "lib/ffi-magic.rb", "lib/ffi-magic/version.rb", "spec/ffi-magic.rb", "spec/magic.png", "tasks/authors.rake", "tasks/changelog.rake", "tasks/gem.rake", "tasks/manifest.rake", "tasks/release.rake", "tasks/reversion.rake", "tasks/todo.rake"]
  s.homepage = %q{http://github.com/manveru/ffi-magic}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{FFI binding for libmagic.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>, ["~> 1.0.7"])
    else
      s.add_dependency(%q<ffi>, ["~> 1.0.7"])
    end
  else
    s.add_dependency(%q<ffi>, ["~> 1.0.7"])
  end
end

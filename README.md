# OasDivider

Divides the OpenAPI format schema definition file described in one file into multiple files.

## Installation

install it yourself as:

    $ gem install oas_divider

## Usage

```shell
oas_divider your_file_to_divide.yml
```

## Behavior
Reads the specified swagger file, cuts out the code in the following units, and saves it to a file.
Embed a ReferenceObject containing a reference to the file in place of the cut out part.

- PathItemObject under PathsObject
- value of the responses field under ComponentsObject
- value of the parameters field under the ComponentsObject
- value of the requestBodies field under the ComponentsObject
- SchemaObject, the value of the map in the schema field under ComponentsObject

Other objects will be output as is.
The file will be output to the current directory.

---

指定されたswaggerファイルを読み込み、以下の単位でコードを切り出してそれをファイルに保存します。
切り出した部分の代わりにそのファイルへのreferenceを含むReferenceObjectを埋め込みます。

- PathsObject配下のPathItemObject
- ComponentsObject配下のresponsesフィールドのvalue
- ComponentsObject配下のparametersフィールドのvalue
- ComponentsObject配下のrequestBodiesフィールドのvalue
- ComponentsObject配下のschemaフィールドのMapのvalueであるSchemaObject

その他のオブジェクトはそのまま出力します。
ファイルはカレントディレクトリに出力されます。

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/oas_divider. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/oas_divider/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OasDivider project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/oas_divider/blob/master/CODE_OF_CONDUCT.md).

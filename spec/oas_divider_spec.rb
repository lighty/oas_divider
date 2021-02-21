RSpec.describe OasDivider do
  it "has a version number" do
    expect(OasDivider::VERSION).not_to be nil
  end

  let(:oas_divider) { OasDivider::Cli.new('spec/fixtures/openapi.yaml') }
  before { oas_divider.divide }
  after { FileUtils.rm_r %w(swagger_root.yml components paths) } # TODO 出力ディレクトリ指定できるようにしないと危険

  specify 'ファイルが作成されること', :aggrigate_failures do
    expect(File).to exist('swagger_root.yml')
  end
end

require 'spec_helper'

RSpec.describe 'Supermarketapi client' do
  before do
    @client = SupermarketApi::Client.new
  end

  it 'should return cookbook properties' do
    allow(@client).to receive(:get).with('/cookbooks/apache2').and_return('apache_info')
    expect(@client.cookbook('apache2')).to match('apache_info')
  end

  it 'should return cookbook version' do
    allow(@client).to receive(:get).with('/cookbooks/apache2/versions/latest').and_return('apache_info v2')
    expect(@client.cookbook_version('apache2', 'latest')).to match('apache_info v2')
  end

  it 'should return information about multiple cookbooks' do
    allow(@client).to receive(:get).with('/cookbooks', { start: 0, items: 50, order: :most_followed, user: 'sous-chefs' }).and_return('apache_info')
    expect(@client.cookbooks(user='sous-chefs')).to match('apache_info')
  end
end

require 'spec_helper'

RSpec.describe 'BitBNS integration specs' do
  client = Cryptoexchange::Client.new
  let(:btc_inr_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'inr', market: 'bitbns') }

  it 'fetch pairs' do
    pairs = client.pairs('bitbns')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitbns'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url btc_inr_pair.market, base: btc_inr_pair.base, target: btc_inr_pair.target
    expect(trade_page_url).to eq "https://bitbns.com/trade/#/btc"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_inr_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'INR'
    expect(ticker.market).to eq 'bitbns'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end

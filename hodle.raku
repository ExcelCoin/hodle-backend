use Cro::HTTP::Server;
use Cro::HTTP::Router;
use Cro::RPC::JSON:api<2>;

constant CHAIN_ID = 24602;

sub tohex($a) {
  return "0x{$a.base(16).lc}";
}

class HodleBackend {
  method rpc_modules() is json-rpc {
    return {"eth" => "1.0"};
  }
  method eth_chainId() is json-rpc {
    return tohex(CHAIN_ID);
  }

  method eth_blockNumber() is json-rpc {
    return tohex(1);
  }

  method eth_getBalance($account_id, $block_number) is json-rpc {
    return tohex(0);
  }

  method eth_getBlockByNumber($block_number, $full_transaction) is json-rpc {
    return {"number" => tohex(1)};
  }

  method eth_call($call_params, $block_spec) is json-rpc {
    # TODO(zhuowei)
    # 42069 x 10^38
    return "0x8e890a7c0e2a4340000";
  }

  method net_version() is json-rpc {
    return CHAIN_ID.Str
  }
}

my $hodle_backend = HodleBackend.new;

my $application = route {
  post -> "" {
    json-rpc $hodle_backend;
  }
}

my Cro::Service $service = Cro::HTTP::Server.new:
    :host<::>, :port<3000>, :$application;
$service.start;
react whenever signal(SIGINT) { $service.stop; exit; }

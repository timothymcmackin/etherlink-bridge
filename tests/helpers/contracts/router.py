from tests.helpers.contracts.contract import ContractHelper
from pytezos.client import PyTezosClient
from tests.helpers.utility import get_build_dir
from pytezos.operation.group import OperationGroup
from os.path import join
from tests.helpers.metadata import make_metadata


def read_router_lambda(lambda_name: str) -> str:
    """ Reads lambda from file """

    filename = join(get_build_dir(), 'route-lambdas', f'{lambda_name}.tz')
    with open(filename) as f:
        return f.read()


class Router(ContractHelper):

    default_storage = {
        'routes': {
            'to_l1_address': read_router_lambda('to-l1-address'),
        },
        'metadata': make_metadata(
            name='Router',
            description='The Router is a component of the Bridge Protocol Prototype, designed to facilitate L2 to L1 transfers.',
        ),
    }

    @classmethod
    def originate_default(cls, client: PyTezosClient) -> OperationGroup:
        """ Deploys Router with precompiled lambdas """

        filename = join(get_build_dir(), 'router.tz')
        return cls.originate_from_file(filename, client, cls.default_storage)
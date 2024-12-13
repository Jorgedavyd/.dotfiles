from sympy import Symbol
import modulus
from modulus.hydra import ModulusConfig
from modulus.solver import Solver
from modulus.domain import Domain
from modulus.domain.constraint import (
    PointwiseBoundaryConstraint,
    PointwiseInteriorConstraint,
    IntegralBoundaryConstraint
)
from model import PhysicsInformedModel
from equations import CustomPDE
from modulus.key import Key

from modulus.geometry.parametrization import Parametrization, Parameter
from modulus.geometry.primitives_3d import Box, Sphere, Cylinder, Plane
from modulus.geometry.primitives_2d import Rectangle, Circle, Line
from modulus.geometry.primitives_1d import Point1D, Line1D
from modulus.geometry.tessellation import Tessellation
from modulus.utils.io.vtk import var_to_polyvtk

def make_geometry():
    return ...

@modulus.main(version_base = "1.3", config_path="conf", config_name="config")
def run(cfg: ModulusConfig) -> None:
    r = Symbol("r") #sample inputs
    t = Symbol("t")
    eq = CustomPDE()

    u_net = PhysicsInformedModel(input_keys=[Key("x")], output_keys=[Key("u")], cfg = cfg)

    nodes = eq.make_nodes() + [u_net.make_node(name="model")]
    geo = make_geometry()
    domain = Domain()

    boundary = PointwiseBoundaryConstraint(
        nodes = nodes, geometry = geo,
        outvar = {"E": 0}, batch_size = 2
    )

    interior = PointwiseInteriorConstraint(
        nodes = nodes, geometry = geo,
        outvar = {"CustomPDE": 0}, batch_size = 100,
        bounds = {r: (0, 210), t: (0, 7200)}
    )

    integral = IntegralBoundaryConstraint(
        nodes = nodes, geometry = geo,
        outvar = {"CustomPDE": 0}, batch_size = 1,
        integral_batch_size = 1000
    ) ## monte carlo integration for this one

    domain.add_constraint(boundary, "bc1")
    domain.add_constraint(integral, "bc2")
    domain.add_constraint(interior, "PDE")

    slv = Solver(cfg, domain)
    slv.solve()

if __name__ == "__main__":
    run()

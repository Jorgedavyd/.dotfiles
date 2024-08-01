from lightorch.nn.criterions import LightorchLoss

class criterion(LightorchLoss):
    def __init__(self, ) -> None:
        super().__init__(
            labels = ,
            factors = ,
        )
    @torch.jit.script
    def forward(self, x: Tensor) -> Tensor:
        return super().forward(x)



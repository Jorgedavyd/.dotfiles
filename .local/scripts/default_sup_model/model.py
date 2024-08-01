from lightorch.training.supervised import Module
from torch import nn
import torch

class model_name(nn.Module):
    def __init__(self, ) -> None:
        super().__init__()
    @torch.jit.script
    def forward(self, x: Tensor) -> Tensor:
        return

class Model(Module):
    def __init__(self, **hparams) -> None:
        super().__init__(**hparams)
        self.model = model_name()
        self.criterion = criterion()
    @torch.jit.script
    def forward(self, x: Tensor) -> Tensor:
        return self.model(x)

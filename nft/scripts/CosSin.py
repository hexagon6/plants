import base64
import json
import sys

from PySide2 import QtCore, QtGui, QtWidgets
from PySide2.QtWebEngineWidgets import QWebEngineView

from brownie import *




def main():
    me = accounts[0]

    c = CosSin.deploy({'from': me})


    print("Cosinus")
    print(c.cos(0))
    print(c.cos(78539816339))   # pi/4
    print(c.cos(157079632679))  # 2*pi/4
    print(c.cos(235619449019))  # 3*pi/4
    print(c.cos(314159265359))  # 4*pi/4
    print(c.cos(392699081699))  # 5*pi/4
    print(c.cos(471238898038))  # 6*pi/4
    print(c.cos(549778714378))  # 7*pi/4
    print(c.cos(628318530718))  # 8*pi/4

    print("\nSinus")
    print(c.sin(0))
    print(c.sin(78539816339))   # pi/4
    print(c.sin(157079632679))  # 2*pi/4
    print(c.sin(235619449019))  # 3*pi/4
    print(c.sin(314159265359))  # 4*pi/4
    print(c.sin(392699081699))  # 5*pi/4
    print(c.sin(471238898038))  # 6*pi/4
    print(c.sin(549778714378))  # 7*pi/4
    print(c.sin(628318530718))  # 8*pi/4

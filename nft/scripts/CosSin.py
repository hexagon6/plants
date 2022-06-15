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
    print(c.cos(45))   # pi/4
    print(c.cos(90))  # 2*pi/4
    print(c.cos(135))  # 3*pi/4
    print(c.cos(180))  # 4*pi/4
    print(c.cos(225))  # 5*pi/4
    print(c.cos(270))  # 6*pi/4
    print(c.cos(315))  # 7*pi/4
    print(c.cos(360))  # 8*pi/4


    print("\nSinus")

export const koch = {
  id: 0,
  name: 'Koch Curve',
  axiom: 'F-F-F-F',
  productions: { F: 'F-F+F+FF-F-F+F' },
}

export const branchA = {
  id: 1,
  name: 'branchA',
  axiom: 'F',
  productions: { F: 'F[+F]F[-F]F' },
  n: 5,
  degree: 25.7,
}

export const branchB = {
  id: 2,
  name: 'branchB',
  axiom: 'F',
  productions: { F: 'F[+F]F[-F][F]' },
  n: 5,
  degree: 20,
}

export const branchC = {
  id: 3,
  name: 'branchC',
  axiom: 'F',
  productions: {
    F: 'FF-[-F+F+F]+[+F-F-F]',
  },
  n: 4,
  degree: 22.5,
}

export const branchD = {
  id: 4,
  name: 'branchD',
  axiom: 'X',
  productions: { X: 'F[+X]F[-X]+X', F: 'FF' },
  n: 7,
  degree: 20,
}

export const branchE = {
  id: 5,
  name: 'branchE',
  axiom: 'X',
  productions: { X: 'F[+X][-X]FX', F: 'FF' },
  n: 7,
  degree: 25.7,
}

export const branchF = {
  id: 6,
  name: 'branchF',
  axiom: 'X',
  productions: { X: 'F-[[X]+X]+F[+FX]-X', F: 'FF' },
  n: 5,
  degree: 22.5,
}

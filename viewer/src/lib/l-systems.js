export const tree1 = {
	id: 0,
	name: 'Tree1',
	axiom: 'X',
	productions: { X: () => 'F[+X]FF[-X]+X', F: () => 'FF' },
}

export const koch = {
	id: 1,
	name: 'Koch Curve',
	axiom: 'F-F-F-F',
	productions: { F: () => 'F-F+F+FF-F-F+F' },
}

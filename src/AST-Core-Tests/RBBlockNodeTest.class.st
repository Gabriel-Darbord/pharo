Class {
	#name : #RBBlockNodeTest,
	#superclass : #RBParseTreeTest,
	#category : #'AST-Core-Tests-Nodes'
}

{ #category : #tests }
RBBlockNodeTest >> testConstantValue [

	self assert: [  ] sourceNode constantValue equals: nil.
	self assert: [ 1 ] sourceNode constantValue equals: 1.
	self should: [[ ^1 ] sourceNode constantValue] raise: TestResult error
]

{ #category : #tests }
RBBlockNodeTest >> testHasNonLocalReturn [

	self deny: [  ] sourceNode hasNonLocalReturn.
	self deny: [ [  ] ] sourceNode hasNonLocalReturn.
	self assert: [ ^ 1 ] sourceNode hasNonLocalReturn.
	self assert: [ [ ^ 1 ] ] sourceNode hasNonLocalReturn.
	self assert: (self class>>#testHasNonLocalReturn) ast hasNonLocalReturn.
	"return on the level of the method is a local return"
	self deny: (Object>>#yourself) ast hasNonLocalReturn.
	self deny: (Object>>#halt) ast hasNonLocalReturn
]

{ #category : #tests }
RBBlockNodeTest >> testIsConstant [

	self assert: [  ] sourceNode isConstant.
	self assert: [ 1 ] sourceNode isConstant.
	self deny: [ ^1 ] sourceNode isConstant.
	self deny: [ 1 sin. 1 ] sourceNode isConstant
]
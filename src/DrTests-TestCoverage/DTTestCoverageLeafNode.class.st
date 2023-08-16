"
I am a subclass that fits the need of DT Coverage plugin.

I rewrite the drTestName method to show only the name of method and facilitate a better visualization in the grouping of classes.
"
Class {
	#name : #DTTestCoverageLeafNode,
	#superclass : #DTTreeLeafNode,
	#category : #'DrTests-TestCoverage'
}

{ #category : #accessing }
DTTestCoverageLeafNode >> drTestsName [
	"unlike DrTestName method father, this method will return only the name of the method (selector)."

	^ self content selector
]

"
I build a tree with information: 
-percent of covered methods in the selected packages
-List of the uncovered methods
I am used in DrTestsUI to show the results in a orderly manner.
"
Class {
	#name : #DTTestCoverageResult,
	#superclass : #DTPluginResult,
	#instVars : [
		'methodList',
		'percent',
		'partiallyCoveredMethods'
	],
	#category : #'DrTests-TestCoverage'
}

{ #category : #'tree building' }
DTTestCoverageResult >> buildTreeByClass: aMethodList [

	| methodsByClasses subResultsTree |
	methodsByClasses := self methodsGroupedByClass: aMethodList.
	subResultsTree := {  }.
	methodsByClasses keysAndValuesDo: [ :key :value |
		| classNode |
		classNode := DTTreeNode new
			             name: key asString;
			             subResults:
				             (value collect: [ :each |
						              each asResultForDrTestCoverage ]);
			             yourself.
		subResultsTree := subResultsTree , { classNode } ].
	^ subResultsTree
]

{ #category : #accessing }
DTTestCoverageResult >> buildTreeForUI [
	<dtTestCoverageResultTreeNamed: 'List of uncovered methods' order: 1>
	^ DTTreeNode new
		subResults: (self methodList 
		ifNotNil: [
        {(DTTreeNode new
            name: (percent * 100 printShowingDecimalPlaces: 2) , ' % Code Coverage';
            subResults: {};
            yourself).
        (DTTreeNode new
            name: 'Uncovered methods';
            subResults: (self buildTreeByClass: methodList );
            yourself).
         (DTTreeNode new
            name: 'Partially covered methods';
            subResults: (self buildTreeByClass: partiallyCoveredMethods );
            yourself)}
    	]ifNil: [
       	 {(DTTreeNode new
        	    name: 'no package has been selected';
      	 	    subResults: {};
             yourself)}
    	])
]

{ #category : #accessing }
DTTestCoverageResult >> methodList [
	^methodList
]

{ #category : #accessing }
DTTestCoverageResult >> methodList: aCollectionOfMethods [
	methodList := aCollectionOfMethods
]

{ #category : #'tree building' }
DTTestCoverageResult >> methodsGroupedByClass: compiledMethods [

	| dictionary |
	dictionary := Dictionary new.
	compiledMethods do: [ :method |
		| class |
		class := method methodClass.
		(dictionary at: class ifAbsentPut: [ OrderedCollection new ]) add:
			method ].
	^ dictionary
]

{ #category : #accessing }
DTTestCoverageResult >> partiallyCoveredMethods [

	^ partiallyCoveredMethods
]

{ #category : #accessing }
DTTestCoverageResult >> partiallyCoveredMethods: aCollectionOfMethods [

	partiallyCoveredMethods := aCollectionOfMethods
]

{ #category : #accessing }
DTTestCoverageResult >> percent [
	^ percent
]

{ #category : #accessing }
DTTestCoverageResult >> percent: anObject [
	percent := anObject
]

{ #category : #accessing }
DTTestCoverageResult >> summarizeInfo [
	"Text showed in miniDrTests with info of the result "

	^ String
		streamContents: [ :s |
			s
				<< (percent*100 printShowingDecimalPlaces: 2);
				<< ' % Code Coverage';
				<< String cr;
				<< 'Uncovered methods:';
				<< String cr;
				<< self methodList size asString ]
]

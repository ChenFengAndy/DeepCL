cdef class NetLearner: 
    cdef cDeepCL.CyNetLearner[float] *thisptr
    def __cinit__( self, NeuralNet neuralnet ):
        self.thisptr = new cDeepCL.CyNetLearner[float]( neuralnet.thisptr )
    def __dealloc(self):
        del self.thisptr
    def setTrainingData( self, Ntrain, float[:] trainData, int[:] trainLabels ):
        self.thisptr.setTrainingData( Ntrain, &trainData[0], &trainLabels[0] )
    def setTestingData( self, Ntest, float[:] testData, int[:] testLabels ):
        self.thisptr.setTestingData( Ntest, &testData[0], &testLabels[0] )
    def setSchedule( self, numEpochs ):
        self.thisptr.setSchedule( numEpochs )
    def setDumpTimings( self, bint dumpTimings ):
        self.thisptr.setDumpTimings( dumpTimings )
    def setBatchSize( self, batchSize ):
        self.thisptr.setBatchSize( batchSize )
    def _learn( self, float learningRate ):
        with nogil:
            self.thisptr.learn( learningRate )
    def learn( self, float learningRate ):
        interruptableCall( self._learn, [ learningRate ] ) 
#        with nogil:
#            thisptr._learn( learningRate )
        checkException()



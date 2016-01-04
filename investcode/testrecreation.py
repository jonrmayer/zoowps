import zoo
def testrecreation(conf,inputs,outputs):
    outputs["Result"]["value"]=\
            "Hello "+inputs["a"]["value"]+" from the ZOO-Project Python world !"
    return zoo.SERVICE_SUCCEEDED

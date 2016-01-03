import zoo
def testgeo_ms(conf,inputs,outputs):
        outputs["Result"]["value"]=inputs["InputPolygon"]["value"]
        return zoo.SERVICE_SUCCEEDED

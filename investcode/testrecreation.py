import zoo
from natcap.invest.recreation import recreation_client
args = {
        u'aoi_file_name': u'/usr/local/natcap/data/edinburghAOI_UTM_new.shp',
        u'cell_size': 3000.0,
        u'comments': u'',
        u'data_dir': u'',
        u'download': False,
        u'global_data': True,
        u'grid': True,
        u'grid_type': u'0',
        u'landscan': True,
        u'lulc': False,
        u'mode': u'initial',
        u'osm': False,
        u'workspace_dir': u'/usr/local/natcap/test',
}
def testrecreation(conf,inputs,outputs):
        recreation_client.execute(args)
        outputs["Result"]["value"]='natcap success'
        return zoo.SERVICE_SUCCEEDED

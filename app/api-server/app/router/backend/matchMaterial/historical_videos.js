'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const historicalVideos = controller.matchMaterial.historicalVideos
   const prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/matchMaterial/historical_videos/all',historicalVideos.index);
   router.get(prefix+'/matchMaterial/historical_videos/findOneByCid', historicalVideos.findOneByCid);
   router.post(prefix+'/matchMaterial/historical_videos/create',  historicalVideos.create);
   router.post(prefix+'/matchMaterial/historical_videos/update', historicalVideos.update);
   router.post(prefix+'/matchMaterial/historical_videos/delete', historicalVideos.destroy);
};

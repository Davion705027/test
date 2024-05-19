// This file is created by egg-ts-helper@1.35.1
// Do not modify this file!!!!!!!!!
/* eslint-disable */

import 'egg';
import ExportAdminRecord = require('../../../app/middleware/adminRecord');
import ExportAuth = require('../../../app/middleware/auth');
import ExportCost = require('../../../app/middleware/cost');
import ExportErrorHandler = require('../../../app/middleware/errorHandler');
import ExportJwterr = require('../../../app/middleware/jwterr');

declare module 'egg' {
  interface IMiddleware {
    adminRecord: typeof ExportAdminRecord;
    auth: typeof ExportAuth;
    cost: typeof ExportCost;
    errorHandler: typeof ExportErrorHandler;
    jwterr: typeof ExportJwterr;
  }
}

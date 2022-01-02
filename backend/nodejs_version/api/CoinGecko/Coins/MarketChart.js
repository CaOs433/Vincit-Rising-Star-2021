"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getData = void 0;
const Convert = __importStar(require("./Convert"));
const index_1 = __importDefault(require("../../../node_modules/axios/index"));
const BASE_URL = 'https://api.coingecko.com/api/v3/coins';
/**
 *
 * @param from start date for the range in timestamp (seconds since 1970)
 * @param to end date for the range in timestamp (seconds since 1970)
 * @param coin cryptocurrency id (default is bitcoin)
 * @param vs_currency the currency to show the values in (default is eur)
 * @returns all data parsed in TypeScript interface
 */
function getData(from, to, coin = 'bitcoin', vs_currency = 'eur') {
    return __awaiter(this, void 0, void 0, function* () {
        // Full URL
        const url = `${BASE_URL}/${coin}/market_chart/range?vs_currency=${vs_currency}&from=${from}&to=${to}`;
        // Fetch data from the server
        const res = yield index_1.default.get(url);
        // Was the request succesfull?
        if (res.status === 200) {
            // Success
            console.log("(200): success");
            // Get the data from response
            const data = yield res.data;
            // Print data into console
            //console.log("Data: ", data);
            // Try to convert data
            try {
                return Convert.getAllFromRangeJSON(JSON.stringify(data));
            }
            catch (e) {
                console.log("Error: ", e);
            }
        }
        else {
            // Request wasn't succesfull
            console.log(`Error: status code (${res.status})`);
        }
    });
}
exports.getData = getData;

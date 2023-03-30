//
//  AccountInfoResponse.swift
//  HaqqWeb3UtilsRN
//
//  Created by Andrey Makarov on 30.01.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//

import Foundation

struct AccountInfoResponse: Codable {
  var address: String;
  var publicKey: String;
  var publicKeyUncompressed: String;

  public func toJSON() throws -> String {
    let jsonEncoder = JSONEncoder();

    guard let encode = try? jsonEncoder.encode(self) else {
      throw Web3UtilsError.encode_json;
    }

    guard let resp = String(data: encode, encoding: .utf8) else {
      throw Web3UtilsError.encode_json;
    }

    return resp
  }
}

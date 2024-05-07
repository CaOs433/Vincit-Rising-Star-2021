//
//  APIErrorView.swift
//  Vincit-Rising-Star-v1
//
//  Created by Oskari Saarinen on 7.5.2024.
//

import SwiftUI

struct APIErrorView: View {
    @Binding public var apiError: APIError?
    
    var body: some View {
        Text("The API Server returned an error!")
            .font(.title2)
            .bold()
        
        if let status = self.apiError?.error.status {
            ScrollView {
                VStack(alignment: .leading, content: {
                    Text("Timestamp:")
                        .font(.title3)
                        .bold()
                    Text(status.timestamp)
                        .font(.callout)
                    
                    Text("\nError code:")
                        .font(.title3)
                        .bold()
                    Text("\(status.error_code)")
                        .font(.callout)
                    
                    Text("\nError message:")
                        .font(.title3)
                        .bold()
                    Text(status.error_message)
                        .font(.callout)
                })
            }
        }
    }
}

#Preview {
    APIErrorView(apiError:
        .constant(
            APIError(
                error: APIError.Error(
                    status: APIError.Status(
                        timestamp: "2024-05-06T15:54:45.314+00:00",
                        error_code: 10012,
                        error_message: "Your request exceeds the allowed time range. Public API users are limited to querying historical data within the past 365 days. Upgrade to a paid plan to enjoy full historical data access: https://www.coingecko.com/en/api/pricing."
                    )
                )
            )
        )
    )
}

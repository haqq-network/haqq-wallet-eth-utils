package haqq.web3utilsrn

import kotlinx.serialization.Serializable

@Serializable
data class AccountInfoResponse(val address: String, val publicKey: String, val publicKeyUncompressed: String)

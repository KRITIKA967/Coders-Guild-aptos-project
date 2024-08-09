// payment_made.move
module payment_system::payment_made {
    use std::error;
    use std::signer;
    use std::string;

    // Event to notify when a payment is made
    struct PaymentMade has drop, store {
        amount: u64,
        sender: address,
        receiver: address,
    }
}
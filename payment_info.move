// payment_info.move
module payment_system::payment_info {
    use std::error;
    use std::signer;
    use std::string;

    // Resource to store the payment information
    struct PaymentInfo has key {
        amount: u64,
        sender: address,
        receiver: address,
    }
}
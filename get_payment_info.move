// get_payment_info.move
module payment_system::get_payment_info {
    use payment_system::payment_info::PaymentInfo;
    use std::error;
    use std::signer;
    use std::string;

    // Function to get the payment information
    public fun get_payment_info(account: address): PaymentInfo {
        borrow_global<PaymentInfo>(account)
    }
}
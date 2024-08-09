// make_payment.move
module payment_system::make_payment {
    use payment_system::payment_info::PaymentInfo;
    use payment_system::payment_made::PaymentMade;
    use std::error;
    use std::signer;
    use std::string;

    // Function to make a payment
    public entry fun make_payment(account: signer, amount: u64, receiver: address) {
        let sender_addr = signer::address_of(&account);
        let payment_info = PaymentInfo {
            amount,
            sender: sender_addr,
            receiver,
        };
        move_to(&account, payment_info);
        event::emit(PaymentMade {
            amount,
            sender: sender_addr,
            receiver,
        });
    }
}
module payment_addr::Payment {

    use std::signer;

    const E_INSUFFICIENT_BALANCE: u64 = 0;
    const E_INVALID_ACCOUNT: u64 = 1;
    const E_INVALID_AMOUNT: u64 = 2;

    struct Account has key {
        balance: u64,
    }

    public fun assert_is_initialized(account_addr: address) {
        assert!(exists<Account>(account_addr), E_INVALID_ACCOUNT);
    }

    public fun assert_valid_amount(amount: u64) {
        assert!(amount > 0, E_INVALID_AMOUNT);
    }

    public entry fun initialize(account: &signer) {
        let signer_address = signer::address_of(account);

        if (!exists<Account>(signer_address)) {
            let account_store = Account { balance: 0 };
            move_to(account, account_store);
        }
    }

    public entry fun deposit(account: &signer, amount: u64) acquires Account {
        let signer_address = signer::address_of(account);

        assert_is_initialized(signer_address);
        assert_valid_amount(amount);

        let account_store = borrow_global_mut<Account>(signer_address);
        account_store.balance = account_store.balance + amount;
    }

    public entry fun transfer(account: &signer, receiver: address, amount: u64) acquires Account {
        let signer_address = signer::address_of(account);

        assert_is_initialized(signer_address);
        assert_is_initialized(receiver);
        assert_valid_amount(amount);

        let sender_account = borrow_global_mut<Account>(signer_address);
        assert!(sender_account.balance >= amount, E_INSUFFICIENT_BALANCE);

        // Update sender's balance first
        sender_account.balance = sender_account.balance - amount;

        // Then borrow the receiver account and update its balance
        let receiver_account = borrow_global_mut<Account>(receiver);
        receiver_account.balance = receiver_account.balance + amount;
    }

    public entry fun withdraw(account: &signer, amount: u64) acquires Account {
        let signer_address = signer::address_of(account);

        assert_is_initialized(signer_address);
        assert_valid_amount(amount);

        let account_store = borrow_global_mut<Account>(signer_address);
        assert!(account_store.balance >= amount, E_INSUFFICIENT_BALANCE);

        account_store.balance = account_store.balance - amount;
    }

    #[view]
    public fun get_balance(account: address): u64 acquires Account {
        let account_store = borrow_global<Account>(account);
        account_store.balance
    }
}
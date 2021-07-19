<div class="app_modal" data-modalclose="true">
    <!--INCOME-->
    <?php
    $user = user();
    $wallets = (new \Source\Models\CafeApp\AppWallet())
        ->find("user_id = :u", "u={$user->id}", "id, wallet")
        ->order("wallet")
        ->fetch(true);

    $v->insert("views/invoice", [
        "type" => "income",
        "wallets" => $wallets,
        "categories" => (new \Source\Models\CafeApp\AppCategory())
            ->find("type = :t", "t=income", "id, name")
            ->order("order_by, name")
            ->fetch(true)
    ]);

    $v->insert("views/invoice", [
        "type" => "expense",
        "wallets" => $wallets,
        "categories" => (new \Source\Models\CafeApp\AppCategory())
            ->find("type = :t", "t=expense", "id, name")
            ->order("order_by, name")
            ->fetch(true)
    ]);
    ?>


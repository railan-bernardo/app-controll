<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">

    <?= $head; ?>
    <link rel="stylesheet" href="<?= url("/shared/styles/styles.css"); ?>"/>
<link rel="stylesheet" href="<?= url("/shared/styles/boot.css"); ?>"/>
<link rel="stylesheet" href="<?= theme("/assets/css/message.css", CONF_VIEW_APP); ?>"/>
    <link rel="stylesheet" href="<?= theme("/assets/css/style.css", CONF_VIEW_APP); ?>"/>
    <link rel="icon" type="image/png" href="<?= theme("/assets/images/favicon.png", CONF_VIEW_APP); ?>"/>
</head>
<body>

<div class="ajax_load">
    <div class="ajax_load_box">
        <div class="ajax_load_box_circle"></div>
        <p class="ajax_load_box_title">Aguarde, carregando...</p>
    </div>
</div>

<div class="app">
    <header class="app_header">
        <h1><a class="icon-coffee transition" href="<?= url("/app"); ?>" title="CaféApp">AppControl</a></h1>
        <ul class="app_header_widget">
            <li class="radius icon-filter wallet"> <?= (session()->has("walletfilter") ? (new \Source\Models\CafeApp\AppWallet())->findById(session()->walletfilter)->wallet : "Saldo Geral"); ?>
                <ul>
                    <?php if (session()->has("walletfilter")): ?>
                        <li class="radius icon-briefcase" data-walletfilter="<?= url("/app/dash"); ?>"
                            data-wallet="all">Saldo Geral
                        </li>
                    <?php endif; ?>

                    <?php
                    $userId = user()->id;
                    $wallets = (new \Source\Models\CafeApp\AppWallet())
                        ->find("user_id = :user", "user={$userId}")
                        ->order("wallet")
                        ->fetch(true);

                    foreach ($wallets as $walletIt):
                        if (!session()->has("walletfilter") || $walletIt->id != session()->walletfilter):
                            ?>
                            <li class="radius icon-suitcase" data-walletfilter="<?= url("/app/dash"); ?>"
                                data-wallet="<?= $walletIt->id; ?>"><?= $walletIt->wallet; ?></li>
                        <?php
                        endif;
                    endforeach;
                    ?>
                </ul>
            </li>
            <li data-mobilemenu="open" class="app_header_widget_mobile radius transition icon-menu icon-notext"></li>
        </ul>
    </header>

    <div class="app_box">
        <nav class="app_sidebar radius box-shadow">
            <div data-mobilemenu="close"
                 class="app_sidebar_widget_mobile radius transition icon-error icon-notext"></div>

            <div class="app_sidebar_user app_widget_title">
                <span class="user">
                    <?php if (user()->photo()): ?>
                        <img class="rounded" alt="<?= user()->first_name; ?>" title="<?= user()->first_name; ?>"
                             src="<?= url("/storage/". user()->photo); ?>"/>
                    <?php else: ?>
                        <img class="rounded" alt="<?= user()->first_name; ?>" title="<?= user()->first_name; ?>"
                             src="<?= theme("/assets/images/avatar.jpg", CONF_VIEW_APP); ?>"/>
                    <?php endif; ?>
                    <span><?= user()->first_name; ?></span>
                </span>

                <?php
                $subscribe = (new \Source\Models\CafeApp\AppSubscription())
                    ->find("user_id = :user AND status != :status", "user={$userId}&status=canceled")
                    ->fetch();

                if ($subscribe):?>
                    <span class="plan radius icon-star"><?= $subscribe->plan()->name; ?></span>
                <?php else: ?>
                    <span class="plan radius">FREE</span>
                <?php endif; ?>
            </div>

            <?= $v->insert("views/sidebar"); ?>
        </nav>

        <main class="app_main">
            <div class="al-center"><?= flash(); ?></div>
            <?= $v->section("content"); ?>
        </main>
    </div>

    <footer class="app_footer">
        <span class="icon-coffee">
            AppControl - Desenvolvido para fins de teste<br>
            &copy; Railan Bernardo - Todos os direitos reservados
        </span>
    </footer>

    <?= $v->insert("views/modals"); ?>
</div>


<script src="<?= url("/shared/scripts/jquery.min.js"); ?>"></script>
<script src="<?= url("/shared/scripts/jquery.form.js"); ?>"></script>
<script src="<?= url("/shared/scripts/jquery-ui.js"); ?>"></script>
<script src="<?= url("/shared/scripts/jquery.mask.js"); ?>"></script>
<script src="<?= url("/shared/scripts/highcharts.js"); ?>"></script>
<script src="<?= url("/shared/scripts/tracker.js"); ?>"></script>
<script src="<?= theme("/assets/js/scripts.js", CONF_VIEW_APP); ?>"></script>
   
<?= $v->section("scripts"); ?>

</body>
</html>


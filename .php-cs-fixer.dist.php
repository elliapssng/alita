<?php

declare(strict_types = 1);

$finder = (new PhpCsFixer\Finder())
    ->in(__DIR__)
    ->exclude('var')
;

return (new PhpCsFixer\Config())
    ->setRules([
        '@PSR1'                  => true,
        '@PSR2'                  => true,
        '@PSR12'                 => true,
        '@PSR12:risky'           => true,
        '@Symfony'               => true,
        '@Symfony:risky'         => true,
        '@PHP81Migration'        => true,
        '@PHP80Migration:risky'  => true,
        'array_syntax'           => ['syntax' => 'short'],
        'fopen_flags'            => false,
        'protected_to_private'   => true,
        'binary_operator_spaces' => [
            'default' => 'align_single_space_minimal',
        ],
        'declare_equal_normalize' => [
            'space' => 'single',
        ],
        'native_function_invocation' => [
            'include' => ['@compiler_optimized'],
            'scope'   => 'namespaced',
        ],
        'no_superfluous_phpdoc_tags' => false,
        'array_push'                 => true,
    ])
    ->setFinder($finder)
    ->setRiskyAllowed(true)
    ->setUsingCache(false)
;

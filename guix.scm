;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;; CIcaDA - Guix Package Definition
;; Run: guix shell -D -f guix.scm
;; Primary package manager for the RSR ecosystem

(use-modules (guix packages)
             (guix gexp)
             (guix git-download)
             (guix build-system trivial)
             ((guix licenses) #:prefix license:)
             (gnu packages base)
             (gnu packages julia)
             (gnu packages ssh)
             (gnu packages tls)
             (gnu packages version-control)
             (gnu packages documentation))

(define-public cicada
  (package
    (name "cicada")
    (version "0.1.0")
    (source (local-file "." "cicada-checkout"
                        #:recursive? #t
                        #:select? (git-predicate ".")))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let* ((out (assoc-ref %outputs "out"))
                (source (assoc-ref %build-inputs "source"))
                (share (string-append out "/share/cicada"))
                (bin (string-append out "/bin")))
           ;; Copy source files
           (mkdir-p share)
           (copy-recursively source share)
           ;; Create wrapper script
           (mkdir-p bin)
           (call-with-output-file (string-append bin "/cicada")
             (lambda (port)
               (format port "#!~a~%exec ~a --project=~a ~a/src/main.jl \"$@\"~%"
                       (string-append (assoc-ref %build-inputs "bash") "/bin/sh")
                       (string-append (assoc-ref %build-inputs "julia") "/bin/julia")
                       share
                       share)))
           (chmod (string-append bin "/cicada") #o755)
           #t))))
    (native-inputs
     (list git))
    (inputs
     (list julia
           openssh
           openssl
           bash))
    (propagated-inputs
     (list openssh openssl))
    (synopsis "Quantum-Resistant Cryptographic Identity Management")
    (description
     "CIcaDA (Palimpsest Crypto Identity) is a Julia-based cryptographic
identity management system focused on quantum-resistant SSH key generation
and advanced security protocols.  Features include multi-factor authentication,
cross-platform support, and an integrated malware scanner.")
    (home-page "https://github.com/hyperpolymath/cicada")
    (license license:agpl3+)))

;; Development shell - use with: guix shell -D -f guix.scm
(packages->manifest
 (list cicada
       julia
       openssh
       openssl
       git
       ;; Documentation tools
       asciidoc))

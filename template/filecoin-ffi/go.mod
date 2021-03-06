module github.com/filecoin-project/filecoin-ffi

go 1.13

require (
	github.com/filecoin-project/go-address v0.0.3
	github.com/filecoin-project/go-fil-commcid v0.0.0-20200716160307-8f644712406f
	github.com/filecoin-project/go-state-types v0.0.0-20200904021452-1883f36ca2f4
	github.com/filecoin-project/specs-actors v0.9.4
	github.com/ipfs/go-cid v0.0.7
	github.com/pkg/errors v0.9.1
	github.com/stretchr/testify v1.6.1
	github.com/xlab/c-for-go v0.0.0-20200718154222-87b0065af829
	golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1
)

replace github.com/xlab/c-for-go => github.com/Kubuxu/c-for-go v0.0.0-20200729154323-9d77fa534f6d

replace github.ciom/filecoin-project/specs-actors => ../specs-actors-v0.9.12

replace github.com/filecoin-project/go-state-types => ../go-state-types



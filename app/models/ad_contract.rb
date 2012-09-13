class AdContract < ActiveRecord::Base
  NAMES = [
    %w(white black blue green silver indigo gold golden ace bam base can cane care city code con cone drill fase fax flex fix hex how high ice in is it job la media lab lam lane line planet plex plus quote street strip tech techi techno trans ware zap zoom zim alpha an ap beta big bio can d- dalt dam dan dento ding dom don don dong double drip duo e- fase fin free fresh fun ganja ganz geo gogo good grave groove hat hay hot hot hot ice inch indi j- jay joy k- kan kay key kin kon konk lam lat lexi lot mat math med move nam new nim o- onto ope open over ozer phys quad quo qvo ran ran rank re red ron round run sail salt san san sao scot sil silicon single sol solo son span stan stat stim strong sub sum sun super tam tamp tan temp tin ton tough tran tree tres trio tripple tris true trust u- una uni uno vaia vento via vila villa viva vol volt voya x- xx- xxx- y- year zaam zam zath zen zer zim zon zoo zot zum zumma zun),
    %w(an ap be ta bio can dam dan din dom don do dub fin geo go hat hot hot jay jo ji joy kay key lam lat lot mat med nam nim ot oze quad quo qvo ran ran red rem ron run sail san san sao sil sol solo son ta sun tam tan tin ton trax trip una uni uno via viva vol za zam zar zat zen zim zoo zoom zo zoz zum zun),
    %w(com core corporation dax dex dexon dom dox electrics electronics ex fan find green holding holdings house ing ity kix lax lane lex lux nix phase ron tam tax taxon tech technology tex texon tom tone touch trax way zone)
  ]

  attr_accessible :company_id
  belongs_to :company

  scope :available, where(:company_id => nil)

  def available?
    company_id.nil?
  end

  def self.generate
    ad_contract = self.new
    ad_contract.advertiser = random_company_name
    ad_contract.price = rand(90) + 10
    ad_contract.save
    ad_contract
  end

  private

  def self.random_company_name
    NAMES.map(&:sample).join.capitalize
  end
end

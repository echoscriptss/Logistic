

//ShipmentF Filter Model
struct ShipmentFilterModel: Encodable {
  let page: Int = 1
  let limit: Int = 25
  let isDelivered: Bool = false
  let assignedToMe: Bool = true
  let sortOrder: String = ""
  let orderBy: String = ""
  let customer: String = ""
  let carrier: String = ""
  let enteredBy: String = ""
  let dispatcher: String = ""
  let pickupStart: String = ""
  let pickupEnd: String = ""
  let deliveryStart: String = ""
  let deliveryEnd: String = ""
  let orderType: String = ""
  let scheduleEarlyDate: String = ""
  let tsa: Bool = false
}

final class OrdersResponseModel: Codable {

    let success: Bool?
    let data: DataContainer?
    let message: String?
    let statusCode: Int?

    // MARK: - Data Container
    struct DataContainer: Codable {
        let orders: OrdersContainer?
        let selectedColumns: [SelectedColumn]?
        let widgets: Widgets?
    }

    // MARK: - Orders Container
    struct OrdersContainer: Codable {
        let data: [Order]?
        let meta: Meta?
    }

    // MARK: - Meta
    struct Meta: Codable {
        let total: Int?
        let lastPage: Int?
        let currentPage: Int?
        let perPage: Int?
        let prev: Int?
        let next: Int?
    }

    // MARK: - Order
    struct Order: Codable {
        let id: Int?
        let uuid: String?
        let orderId: String?
        let orderTypeId: String?
        let enteredUserId: String?
        let equipmentTypeId: String?
        let currMovementId: String?
        let temperatureMin: Int?
        let temperatureMax: Int?
        let setpointTemp: Int?
        let pieces: Int?
        let billDistance: Int?
        let blnum: String?
        let freightCharge: Double?
        let orderedDate: String?
        let status: String?

        let trailer: Trailer?
        let currentMovement: Movement?
        let pickupStop: Stop?
        let deliveryStop: Stop?
        let datalakeIOTData: [IOTData]?

        let commodity: String?
        let dslyTrackingdeviceid: String?
        let dslyTrackingplatform: String?
        let customer: [Customer]?
        let stops: [StopDetail]?

        enum CodingKeys: String, CodingKey {
            case id, uuid, orderId, orderTypeId, enteredUserId
            case equipmentTypeId, currMovementId
            case temperatureMin, temperatureMax, setpointTemp
            case pieces, billDistance, blnum
            case freightCharge
            case orderedDate, status
            case trailer
            case currentMovement
            case pickupStop
            case deliveryStop
            case datalakeIOTData = "DatalakeIOTData"
            case commodity
            case dslyTrackingdeviceid
            case dslyTrackingplatform
            case customer
            case stops
        }
    }

    // MARK: - Trailer
    struct Trailer: Codable {
        let id: Int?
        let uuid: String?
        let assetId: String?
        let assetName: String?
        let temperature: Double?
        let latitude: Double?
        let longitude: Double?
        let battery: Int?
        let lastLocation: String?
        let lastReportDate: String?
    }

    // MARK: - Movement
    struct Movement: Codable {
        let id: Int?
        let uuid: String?
        let mcleodMovementId: String?
        let brokerageStatus: String?
        let nextSchedCall: String?
        let carrier: Carrier?

        enum CodingKeys: String, CodingKey {
            case id, uuid, mcleodMovementId
            case brokerageStatus
            case nextSchedCall
            case carrier = "Carrier"
        }
    }

    // MARK: - Carrier
    struct Carrier: Codable {
        let id: Int?
        let uuid: String?
        let name: String?
        let city: String?
        let state: String?
        let zipCode: String?
    }

    // MARK: - Stop (Pickup / Delivery)
    struct Stop: Codable {
        let id: Int?
        let uuid: String?
        let schedArriveEarly: String?
        let schedArriveLate: String?
        let latitude: Double?
        let longitude: Double?
        let locationName: String?
        let cityName: String?
        let state: String?
    }

    // MARK: - Stop Detail
    struct StopDetail: Codable {
        let id: Int?
        let cityName: String?
        let state: String?
        let stopType: String?
        let schedArriveEarly: String?
        let schedArriveLate: String?
    }

    // MARK: - IoT Data
    struct IOTData: Codable {
        let id: Int?
        let temperature: Double?
        let latitude: Double?
        let longitude: Double?
        let address1: String?
        let modified: String?
    }

    // MARK: - Customer
    struct Customer: Codable {
        let id: Int?
        let uuid: String?
        let customerId: String?
        let name: String?
    }

    // MARK: - Selected Column
    struct SelectedColumn: Codable {
        let columnName: String?
        let columnValue: String?
        let isVisible: Bool?
        let sortOrder: Int?
    }

    // MARK: - Widgets
    struct Widgets: Codable {
        let pending_pickup: Int?
        let pre_transit: Int?
        let in_transit: Int?
        let delivered: Int?
        let recovery: Int?
        let rc_expired: Int?
        let at_delivery: Int?
        let available: Int?
        let totalCount: Int?
    }
}

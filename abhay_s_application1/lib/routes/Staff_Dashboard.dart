import 'package:flutter/material.dart';

class StaffDashboard extends StatefulWidget {
  @override
  _StaffDashboardState createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  List<LeaveRequest> leaveRequests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Employee Information
            EmployeeInformation(),

            // TODO: Leave Balance
            LeaveBalance(),

            // TODO: Apply for Leave
            ApplyForLeave(onSubmit: (LeaveRequest leaveRequest) {
              setState(() {
                leaveRequests.add(leaveRequest);
              });
            }),

            // TODO: Upcoming Leave
            UpcomingLeave(leaveRequests: leaveRequests),

            // TODO: Leave Status
            LeaveStatus(leaveRequests: leaveRequests),

            // TODO: Leave History
            LeaveHistory(leaveRequests: leaveRequests),
          ],
        ),
      ),
    );
  }
}

class EmployeeInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Implement the employee information widget
    return Container();
  }
}

class LeaveBalance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Implement the leave balance widget
    return Container();
  }
}

class ApplyForLeave extends StatefulWidget {
  final Function(LeaveRequest) onSubmit;

  ApplyForLeave({required this.onSubmit});

  @override
  _ApplyForLeaveState createState() => _ApplyForLeaveState();
}

class _ApplyForLeaveState extends State<ApplyForLeave> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apply for Leave',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: startDateController,
              decoration: InputDecoration(labelText: 'Start Date'),
            ),
            TextFormField(
              controller: endDateController,
              decoration: InputDecoration(labelText: 'End Date'),
            ),
            TextFormField(
              controller: reasonController,
              decoration: InputDecoration(labelText: 'Reason'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                LeaveRequest leaveRequest = LeaveRequest(
                  startDate: startDateController.text,
                  endDate: endDateController.text,
                  reason: reasonController.text,
                  status: LeaveStatusType.pending,
                );
                widget.onSubmit(leaveRequest);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class UpcomingLeave extends StatelessWidget {
  final List<LeaveRequest> leaveRequests;

  UpcomingLeave({required this.leaveRequests});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement the upcoming leave widget
    return Container();
  }
}

class LeaveStatus extends StatelessWidget {
  final List<LeaveRequest> leaveRequests;

  LeaveStatus({required this.leaveRequests});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement the leave status widget
    return Container();
  }
}

class LeaveHistory extends StatelessWidget {
  final List<LeaveRequest> leaveRequests;

  LeaveHistory({required this.leaveRequests});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Leave History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Display leave history based on leaveRequests
            for (var request in leaveRequests)
              ListTile(
                title: Text('Start Date: ${request.startDate}'),
                subtitle: Text('End Date: ${request.endDate}'),
                trailing: Text('Status: ${request.status}'),
              ),
          ],
        ),
      ),
    );
  }
}

class LeaveRequest {
  final String startDate;
  final String endDate;
  final String reason;
  final LeaveStatusType status;

  LeaveRequest({
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
  });
}

enum LeaveStatusType {
  pending,
  approved,
  rejected,
}
